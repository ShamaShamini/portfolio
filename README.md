Portfolio Website
A modern, responsive single-page portfolio website built with HTML, CSS, and JavaScript, containerized with Docker and served via Nginx.
✨ Features
Dark theme with gradient accents and glow effects
Fully responsive — mobile, tablet, and desktop
Smooth animations — scroll reveal, floating cards, hover effects
Sections — Hero, About, Skills, Projects, Experience, Contact
Contact form with simulated submission
Performance optimized — gzip compression, static asset caching
Dockerized — multi-stage build, non-root user, health checks
🛠️ Tech Stack
HTML5, CSS3, Vanilla JavaScript
Nginx (production server)
Docker (containerization)
Google Fonts (Inter, JetBrains Mono)
🚀 Quick Start with Docker
Prerequisites
Docker installed on your system
Build the Image
docker build -t portfolio .
Run the Container
docker run -d -p 8080:80 --name portfolio portfolio
View the Site
Open your browser and navigate to:
http://localhost:8080
Stop the Container
docker stop portfolio
docker rm portfolio

