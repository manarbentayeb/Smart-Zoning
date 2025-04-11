#!/bin/bash

echo "📁 Creating project directory structure..."

mkdir -p smart-zoning/backend/app/api/v1/routes
mkdir -p smart-zoning/backend/app/core
mkdir -p smart-zoning/backend/app/db
mkdir -p smart-zoning/backend/app/schemas
mkdir -p smart-zoning/backend/app/services
mkdir -p smart-zoning/webapp/lib/pages
mkdir -p smart-zoning/webapp/lib/widgets
mkdir -p smart-zoning/webapp/lib/models
mkdir -p smart-zoning/webapp/lib/services
mkdir -p smart-zoning/mobileapp/lib/pages
mkdir -p smart-zoning/mobileapp/lib/widgets
mkdir -p smart-zoning/mobileapp/lib/models
mkdir -p smart-zoning/mobileapp/lib/services
mkdir -p smart-zoning/docs

# Backend Files
touch smart-zoning/backend/app/api/v1/routes/auth.py
touch smart-zoning/backend/app/api/v1/routes/pos.py
touch smart-zoning/backend/app/api/v1/routes/zone.py
touch smart-zoning/backend/app/api/v1/routes/assignment.py
touch smart-zoning/backend/app/api/v1/routes/path.py
touch smart-zoning/backend/app/api/v1/__init__.py
touch smart-zoning/backend/app/api/__init__.py
touch smart-zoning/backend/app/core/config.py
touch smart-zoning/backend/app/core/clustering.py
touch smart-zoning/backend/app/db/database.py
touch smart-zoning/backend/app/db/models.py
touch smart-zoning/backend/app/schemas/user.py
touch smart-zoning/backend/app/schemas/pos.py
touch smart-zoning/backend/app/schemas/zone.py
touch smart-zoning/backend/app/schemas/assignment.py
touch smart-zoning/backend/app/services/user_service.py
touch smart-zoning/backend/app/services/path_service.py
touch smart-zoning/backend/app/services/notify.py
touch smart-zoning/backend/app/main.py
touch smart-zoning/backend/requirements.txt
touch smart-zoning/backend/README.md

# WebApp Files
touch smart-zoning/webapp/lib/main.dart
touch smart-zoning/webapp/pubspec.yaml
touch smart-zoning/webapp/README.md

# MobileApp Files
touch smart-zoning/mobileapp/lib/main.dart
touch smart-zoning/mobileapp/pubspec.yaml
touch smart-zoning/mobileapp/README.md

# Docs
touch smart-zoning/docs/ERD.png
touch smart-zoning/docs/use_case_diagram.png
touch smart-zoning/docs/architecture_diagram.png
touch smart-zoning/docs/api_endpoints.md
touch smart-zoning/docs/roadmap.md

# Root
touch smart-zoning/.gitignore
touch smart-zoning/README.md

echo "✅ Structure created successfully inside 'smart-zoning/'"
