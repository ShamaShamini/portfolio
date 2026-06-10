FROM node:20-alpine AS builder
WORKDIR /app
COPY . .
RUN set -eux; \
    test -f index.html; \
    test -f css/style.css; \
    test -f js/main.js; \
    echo "All source files validated successfully"

FROM nginx:1.25-alpine AS production
RUN rm -rf /usr/share/nginx/html/* /etc/nginx/conf.d/default.conf
COPY --from=builder /app/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/index.html /usr/share/nginx/html/
COPY --from=builder /app/css/ /usr/share/nginx/html/css/
COPY --from=builder /app/js/ /usr/share/nginx/html/js/

RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:80/ || exit 1
USER nginx
CMD ["nginx", "-g", "daemon off;"]