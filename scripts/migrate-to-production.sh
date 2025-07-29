#!/bin/bash

# Migration script from staging to production
# Based on Supabase chatbot recommendations

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if project IDs are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    print_error "Usage: $0 <STAGING_PROJECT_ID> <PRODUCTION_PROJECT_ID>"
    print_error "Example: $0 abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz"
    exit 1
fi

STAGING_PROJECT_ID=$1
PRODUCTION_PROJECT_ID=$2

print_status "Starting migration from staging to production..."
print_status "Staging Project ID: $STAGING_PROJECT_ID"
print_status "Production Project ID: $PRODUCTION_PROJECT_ID"

# Step 1: Login to Supabase
print_status "Step 1: Logging in to Supabase..."
supabase login

if [ $? -ne 0 ]; then
    print_error "Failed to login to Supabase"
    exit 1
fi
print_success "Successfully logged in to Supabase"

# Step 2: Link to staging project and pull schema
print_status "Step 2: Linking to staging project and pulling schema..."
supabase link --project-ref $STAGING_PROJECT_ID

if [ $? -ne 0 ]; then
    print_error "Failed to link to staging project"
    exit 1
fi
print_success "Successfully linked to staging project"

print_status "Pulling existing schema from staging..."
supabase db pull

if [ $? -ne 0 ]; then
    print_error "Failed to pull schema from staging"
    exit 1
fi
print_success "Successfully pulled schema from staging"

# Step 3: Link to production project
print_status "Step 3: Linking to production project..."
supabase link --project-ref $PRODUCTION_PROJECT_ID

if [ $? -ne 0 ]; then
    print_error "Failed to link to production project"
    exit 1
fi
print_success "Successfully linked to production project"

# Step 4: Generate migration files
print_status "Step 4: Generating migration files..."
supabase db diff -f initial_setup

if [ $? -ne 0 ]; then
    print_error "Failed to generate migration files"
    exit 1
fi
print_success "Successfully generated migration files"

# Step 5: Push migrations to production
print_status "Step 5: Pushing migrations to production..."
print_warning "This will apply all migrations to your production database!"
print_warning "Make sure you have a backup of your production database before proceeding."

read -p "Do you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_status "Migration cancelled by user"
    exit 0
fi

supabase db push

if [ $? -ne 0 ]; then
    print_error "Failed to push migrations to production"
    exit 1
fi
print_success "Successfully pushed migrations to production"

print_success "Migration completed successfully!"
print_status "Your production database now has the same schema as staging"
print_status "Included in the migration:"
print_status "  - Tables"
print_status "  - Policies (Row Level Security)"
print_status "  - Triggers"
print_status "  - Functions"
print_status "  - Extensions" 