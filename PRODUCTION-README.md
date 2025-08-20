# Claude Code Crew - 生产环境快速部署

## 🚀 一键部署

### 前提条件

- Docker
- Docker Compose

### 快速开始

1. **克隆项目**

   ```bash
   git clone https://github.com/to-na/claude-code-crew.git
   cd claude-code-crew
   ```

2. **配置端口（可选）**

   ```bash
   # 如果需要修改端口，创建 .env 文件
   echo "EXPOSED_PORT=8080" > .env
   ```

3. **启动服务**

   ```bash
   docker-compose up -d
   ```

4. **访问应用**

   打开浏览器访问：`http://localhost:3001`

   如果修改了端口，则访问：`http://localhost:你的端口`

## ⚙️ 配置选项

### 环境变量

在项目根目录创建 `.env` 文件来自定义配置：

```env
# 应用暴露端口（默认 3001）
EXPOSED_PORT=3001

# 工作目录挂载路径（默认为当前目录）
WORKSPACE_DIR=/path/to/your/workspace

# Git 配置文件路径（默认为 ~/.gitconfig）
GIT_CONFIG_PATH=/path/to/your/.gitconfig

# SSH 密钥目录路径（默认为 ~/.ssh）
SSH_KEY_PATH=/path/to/your/.ssh
```

### 配置示例

**端口配置：**

```bash
# 使用端口 8080
echo "EXPOSED_PORT=8080" > .env
docker-compose up -d
```

**工作目录配置：**

```bash
# 使用自定义工作目录
cat > .env << EOF
EXPOSED_PORT=3001
WORKSPACE_DIR=/Users/yourname/projects/my-workspace
EOF
docker-compose up -d
```

**完整配置示例：**

```bash
# 创建完整的环境配置
cat > .env << EOF
# 基本配置
EXPOSED_PORT=8080

# 目录挂载
WORKSPACE_DIR=/Users/yourname/projects/workspace
GIT_CONFIG_PATH=/Users/yourname/.gitconfig
SSH_KEY_PATH=/Users/yourname/.ssh
EOF
docker-compose up -d
```

## 🛠️ 常用命令

```bash
# 启动服务
docker-compose up -d

# 查看状态
docker-compose ps

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down

# 重启服务
docker-compose restart

# 重新构建并启动
docker-compose up -d --build

# 完全清理
docker-compose down -v --rmi all
```

## 📋 功能特性

- **Git 工作树管理**：可视化管理 Git worktrees
- **终端会话**：为每个 worktree 创建独立的终端会话
- **实时状态**：显示会话状态（忙碌/等待/空闲）
- **历史记录**：保存终端历史和会话状态

## 🔧 故障排除

### 端口被占用

```bash
# 检查端口使用情况
lsof -i :3001

# 修改端口
echo "EXPOSED_PORT=8080" > .env
docker-compose up -d
```

### 权限问题

```bash
# 确保 Docker 有权限访问当前目录
sudo chown -R $USER:$USER .
```

### 重新构建

```bash
# 如果遇到问题，尝试重新构建
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

## 📞 支持

如果遇到问题：

1. 查看日志：`docker-compose logs`
2. 检查 GitHub Issues
3. 确保 Docker 版本支持 Compose v3.8

---

**就是这么简单！🎉**
