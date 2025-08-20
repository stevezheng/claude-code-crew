.PHONY: help build start stop restart logs status clean

# 默认目标
help: ## 显示帮助信息
	@echo "Claude Code Crew - 生产环境管理命令"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

# 构建和启动
build: ## 构建 Docker 镜像
	@docker-compose build

start: ## 启动服务
	@docker-compose up -d
	@echo "✅ 服务已启动"
	@echo "🌐 访问：http://localhost:$${EXPOSED_PORT:-3001}"

stop: ## 停止服务
	@docker-compose down

restart: ## 重启服务
	@docker-compose restart

# 日志和监控
logs: ## 查看日志
	@docker-compose logs -f

status: ## 查看服务状态
	@docker-compose ps

# 维护
clean: ## 清理资源
	@docker-compose down -v --rmi local

rebuild: ## 重新构建并启动
	@docker-compose down
	@docker-compose build --no-cache
	@docker-compose up -d

# 实用工具
shell: ## 进入容器
	@docker-compose exec claude-code-crew bash

health: ## 检查健康状态
	@curl -f http://localhost:$${EXPOSED_PORT:-3001}/api/health || echo "❌ 服务未响应"

config: ## 查看当前配置
	@echo "📋 当前配置："
	@docker-compose config

check-env: ## 检查环境变量配置
	@echo "🔍 环境变量检查："
	@echo "端口: $${EXPOSED_PORT:-3001}"
	@echo "工作目录: $${WORKSPACE_DIR:-当前目录}"
	@echo "Git配置: $${GIT_CONFIG_PATH:-~/.gitconfig}"
	@echo "SSH密钥: $${SSH_KEY_PATH:-~/.ssh}"

# 快速开始
quick-start: build start ## 构建并启动
	@echo "🎉 Claude Code Crew 已就绪！"
