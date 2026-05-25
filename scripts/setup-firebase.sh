#!/bin/bash
# Setup Firebase App Distribution for DemoShop
# Run this ONCE manually after: firebase login

set -e

PROJECT_ID="demoshop-ios-$(date +%s)"
BUNDLE_ID="com.demoshop.app"

echo "=== Firebase DemoShop Setup ==="
echo ""

echo "Step 1: Creating Firebase project..."
firebase projects:create "$PROJECT_ID" --display-name "DemoShop iOS" || {
    echo "Project may already exist. Enter your project ID:"
    read -r PROJECT_ID
}

echo ""
echo "Step 2: Adding iOS app to Firebase project..."
firebase apps:create IOS "$BUNDLE_ID" \
    --project "$PROJECT_ID" \
    --display-name "DemoShop iOS"

echo ""
echo "Step 3: Getting App ID..."
APP_ID=$(firebase apps:list --project "$PROJECT_ID" --json \
    | python3 -c "import json,sys; apps=json.load(sys.stdin)['result']; \
      app=[a for a in apps if a.get('bundleId')=='$BUNDLE_ID'][0]; \
      print(app['appId'])")
echo "App ID: $APP_ID"

echo ""
echo "Step 4: Creating tester group..."
firebase appdistribution:group:create "testers" \
    --display-name "QA Testers" \
    --project "$PROJECT_ID" || true

echo ""
echo "Step 5: Generating CI token..."
firebase login:ci --no-localhost

echo ""
echo "=== DONE ==="
echo ""
echo "Add these secrets to GitHub:"
echo "  FIREBASE_APP_ID  = $APP_ID"
echo "  FIREBASE_TOKEN   = (the token printed above)"
echo "  JIRA_URL         = https://liennguyen2811.atlassian.net"
echo "  JIRA_EMAIL       = liennguyen2811@gmail.com"
echo "  JIRA_API_TOKEN   = (from .env file)"
echo ""
echo "Run: gh secret set FIREBASE_APP_ID --body \"$APP_ID\""
