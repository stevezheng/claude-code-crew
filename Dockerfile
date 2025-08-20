# 多阶段构建 - 构建阶段
FROM node:18-alpine AS builder

# 安装 pnpm
RUN npm install -g pnpm

# 设置工作目录
WORKDIR /app

# 复制 package.json 文件
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY client/package.json ./client/
COPY server/package.json ./server/

# 安装依赖
RUN pnpm install --frozen-lockfile

# 复制源代码
COPY . .

# 构建项目
RUN pnpm run build

# 生产阶段
FROM node:18-alpine AS production

# 安装必要的系统工具
RUN apk add --no-cache \
    git \
    bash \
    curl \
    openssh-client \
    python3 \
    make \
    g++

# 安装 pnpm
RUN npm install -g pnpm

# 创建非 root 用户
RUN addgroup -g 1001 -S nodejs && \
    adduser -S claude -u 1001

# 设置工作目录
WORKDIR /app

# 复制 package.json 文件（仅生产依赖）
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY server/package.json ./server/

# 仅安装生产依赖
RUN pnpm install --frozen-lockfile --prod

# 从构建阶段复制构建产物
COPY --from=builder /app/server/dist ./server/dist
COPY --from=builder /app/bin ./bin

# 复制其他必要文件
COPY shared ./shared

# 更改所有者
RUN chown -R claude:nodejs /app

# 切换到非 root 用户
USER claude

# 暴露端口
EXPOSE 3001

# 健康检查
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3001/api/health || exit 1

# 启动命令
CMD ["pnpm", "start"]
