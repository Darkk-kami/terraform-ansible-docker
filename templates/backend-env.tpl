# Domain
# This would be set to the production domain with an env var on deployment
DOMAIN=localhost

# Environment: local, staging, production
ENVIRONMENT=local

PROJECT_NAME="Full Stack FastAPI Project"
STACK_NAME=full-stack-fastapi-project

# Backend
BACKEND_CORS_ORIGINS="http://${domain},https://${domain}"
SECRET_KEY=changethis123
FIRST_SUPERUSER=chanllenge@devopsdojo.com
FIRST_SUPERUSER_PASSWORD=devopsdojo57
USERS_OPEN_REGISTRATION=True

# Emails
SMTP_HOST=
SMTP_USER=
SMTP_PASSWORD=
EMAILS_FROM_EMAIL=info@example.com
SMTP_TLS=True
SMTP_SSL=False
SMTP_PORT=587

# Postgres
POSTGRES_SERVER=database
POSTGRES_PORT=5432
POSTGRES_DB=app
POSTGRES_USER=app
POSTGRES_PASSWORD=changethis123