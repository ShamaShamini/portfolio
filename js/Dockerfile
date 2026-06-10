# ============================================
# Stage 1: Build (validate HTML/CSS/JS)
# ============================================
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files (none needed for static site, 
# but keeping stage for future extensibility)
COPY . .

# Validate that all expected files exist
RUN set -eux; \
    test -f index.html; \
    test -f css/style.css; \
    test -f js/main.js; \
    echo "All source files validated successfully"

# ============================================
# Stage 2: Production (nginx)
# ============================================
FROM nginx:1.25-alpine AS production

# Remove default nginx config and static files
RUN rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/default.conf

# Copy static assets
COPY --from=builder /app/index.html /usr/share/nginx/html/
COPY --from=builder /app/css/ /usr/share/nginx/html/css/
COPY --from=builder /app/js/ /usr/share/nginx/html/js/

# Add non-root user for security
RUN addgroup -S -g 101 nginx && \
    adduser -S -u 101 -G nginx -s /sbin/nologin -D nginx && \
    chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:80/ || exit 1

# Run as non-root user
USER nginx

CMD ["nginx", "-g", "daemon off;"]