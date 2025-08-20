# Claude Code Crew - 简化生产版

## 🎯 极简部署

这是一个精简的生产环境配置，只需一个命令即可启动！

### 📋 文件结构

```
claude-code-crew/
├── docker-compose.yml    # 主配置文件
├── Dockerfile           # 镜像构建文件
├── .env                 # 环境变量配置
├── Makefile            # 便捷命令
└── PRODUCTION-README.md # 详细说明
```

### 🚀 一键启动

```bash
# 方法 1：直接启动
docker-compose up -d

# 方法 2：使用 Make（推荐）
make start

# 方法 3：完整流程
make quick-start
```

### ⚙️ 环境配置

**端口配置：**

```bash
# 默认端口 3001
docker-compose up -d

# 自定义端口
echo "EXPOSED_PORT=8080" > .env
docker-compose up -d
```

**目录配置：**

```bash
# 使用自定义工作目录
cat > .env << EOF
EXPOSED_PORT=3001
WORKSPACE_DIR=/path/to/your/workspace
EOF
docker-compose up -d
```

### 🛠️ 常用命令

```bash
make start    # 启动服务
make logs     # 查看日志
make status   # 查看状态
make stop     # 停止服务
make restart  # 重启服务
make health   # 健康检查
make help     # 查看所有命令
```

### 🌐 访问

启动后访问：`http://localhost:3001`（或你配置的端口）

### ✨ 特性

- ⚡ 一键部署，无需复杂配置
- 🔧 环境变量控制端口
- 🏥 内置健康检查
- 📦 多阶段构建优化
- 🔄 自动重启
- 📁 工作目录挂载
- 🔐 Git 配置共享

就是这么简单！🎉
