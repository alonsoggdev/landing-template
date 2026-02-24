#!/bin/bash

echo "🚀 Landing Project Generator"
echo ""

# Directorio donde está el script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TEMPLATE_DIR="$SCRIPT_DIR/../landing-template"
CLIENTS_DIR="$SCRIPT_DIR/../clientes"

read -p "Project name: " PROJECT_NAME

if [ -z "$PROJECT_NAME" ]; then
  echo "❌ Project name cannot be empty."
  exit 1
fi

read -p "Owner email: " OWNER_EMAIL
read -p "Database name: " DB_NAME

DESTINATION_DIR="$CLIENTS_DIR/$PROJECT_NAME"

if [ -d "$DESTINATION_DIR" ]; then
  echo "❌ Directory already exists."
  exit 1
fi

echo ""
echo "📁 Creating project..."

mkdir -p "$CLIENTS_DIR"
cp -R "$TEMPLATE_DIR" "$DESTINATION_DIR"

cd "$DESTINATION_DIR" || exit

echo "🧹 Removing template git history..."
rm -rf .git

echo "🔧 Initializing new git repository..."
git init

echo "⚙️ Creating .env file..."
cp .env.example .env

# Reemplazar valores en .env
sed -i "s|landing.ownerEmail = .*|landing.ownerEmail = \"$OWNER_EMAIL\"|" .env
sed -i "s|database.default.database = .*|database.default.database = $DB_NAME|" .env

echo "📦 Installing dependencies..."
composer install

echo ""
echo "✅ Project $PROJECT_NAME created successfully!"
echo "👉 Location: $DESTINATION_DIR"
echo "👉 You may now run 'php spark migrate'"