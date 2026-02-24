#!/bin/bash

echo "🚀 Production setup"

echo "📦 Installing composer dependencies..."
composer install --no-dev --optimize-autoloader

echo "🗄 Running migrations..."
php spark migrate

echo "🧹 Clearing cache..."
php spark cache:clear

echo "✅ Setup complete."