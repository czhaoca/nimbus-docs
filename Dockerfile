# Nimbus documentation site — builds from the VENDORED contract artifacts
# (openapi.json / ops.json / ws-events.json at the repo root, delivered by
# backend CI). No engine source is needed or referenced (ADR-0008 / #251).
# Stage 1: Build Starlight site (Node.js)
# Stage 2: Serve with nginx

# --- Stage 1: Build Starlight ---
FROM node:22-alpine AS builder

RUN corepack enable && corepack prepare pnpm@10.33.0 --activate

WORKDIR /build

# Copy package files first for caching
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml .npmrc* ./
RUN pnpm install --frozen-lockfile

# Copy the site source, including the vendored contract artifacts
COPY . .

# Build Starlight (output goes to dist/)
RUN pnpm build

# --- Stage 2: Serve ---
FROM nginx:alpine

# Copy built site
COPY --from=builder /build/dist /usr/share/nginx/html

# Nginx config for SPA-like behavior. 8080 is the generic internal
# container port; governed host ports are assigned by the environment
# registry at deploy time, never hardcoded here.
RUN echo 'server { \
    listen 8080; \
    server_name _; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ $uri.html /index.html; \
    } \
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff2?)$ { \
        expires 1y; \
        add_header Cache-Control "public, immutable"; \
    } \
    add_header X-Frame-Options "SAMEORIGIN" always; \
    add_header X-Content-Type-Options "nosniff" always; \
    add_header Referrer-Policy "strict-origin-when-cross-origin" always; \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 8080
