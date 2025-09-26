# Update build.sh
echo '#!/bin/bash
python3 manage.py collectstatic --noinput' > build.sh

# Create package.json
echo '{
    "scripts": {
        "build": "python3 manage.py collectstatic --noinput"
    }
}' > package.json

# Update vercel.json
echo '{
    "version": 2,
    "builds": [
        {
            "src": "ATTENDANCE/wsgi.py",
            "use": "@vercel/python"
        },
        {
            "src": "package.json",
            "use": "@vercel/static-build"
        }
    ],
    "routes": [
        {
            "src": "/static/(.*)",
            "dest": "/static/$1"
        },
        {
            "src": "/(.*)",
            "dest": "/ATTENDANCE/wsgi.py"
        }
    ]
}' > vercel.json