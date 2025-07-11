# SSL Setup Guide for Murder Mystery Game Website

## Overview

Adding SSL (HTTPS) to your website will:
- ✅ Secure user data and payments
- ✅ Improve SEO rankings
- ✅ Build user trust
- ✅ Enable modern web features
- ✅ Fix browser security warnings

## Option 1: Let's Encrypt (Free SSL) - Most Common

### For Shared Hosting (cPanel, Plesk, etc.)

1. **Check if your host supports Let's Encrypt**
   - Most modern hosts do
   - Look for "SSL" or "Let's Encrypt" in your control panel

2. **Enable SSL in your hosting control panel**
   ```
   cPanel → SSL/TLS → Let's Encrypt SSL
   Plesk → Domains → SSL/TLS → Let's Encrypt
   ```

3. **Select your domain and install**
   - Choose your domain (e.g., `yourdomain.com`)
   - Click "Install" or "Issue"
   - Wait 5-10 minutes for activation

### For VPS/Dedicated Server

1. **Install Certbot** (Let's Encrypt client):
   ```bash
   # Ubuntu/Debian
   sudo apt update
   sudo apt install certbot

   # CentOS/RHEL
   sudo yum install certbot
   ```

2. **Get SSL certificate**:
   ```bash
   # For Apache
   sudo certbot --apache -d yourdomain.com

   # For Nginx
   sudo certbot --nginx -d yourdomain.com

   # For standalone (if no web server)
   sudo certbot certonly --standalone -d yourdomain.com
   ```

3. **Auto-renewal setup**:
   ```bash
   sudo crontab -e
   # Add this line:
   0 12 * * * /usr/bin/certbot renew --quiet
   ```

## Option 2: Cloudflare (Free SSL Proxy)

### Setup Steps

1. **Sign up for Cloudflare** (free tier)
2. **Add your domain**
3. **Update nameservers** to Cloudflare's
4. **Enable SSL/TLS**:
   - Go to SSL/TLS settings
   - Set mode to "Flexible" or "Full"
   - Enable "Always Use HTTPS"

### Benefits
- ✅ Free SSL
- ✅ CDN for faster loading
- ✅ DDoS protection
- ✅ No server configuration needed

## Option 3: Hosting Provider SSL

### Popular Hosting Providers

**Netlify/Vercel** (if using these):
- SSL is automatic and free
- No configuration needed

**GitHub Pages**:
- SSL is automatic for custom domains
- Just add your domain in repository settings

**AWS/Azure/GCP**:
- Use their certificate managers
- Or upload your own certificates

## Option 4: Paid SSL Certificates

### When to Consider
- Enterprise requirements
- Extended validation needed
- Wildcard certificates required

### Popular Providers
- DigiCert
- GlobalSign
- Comodo
- GoDaddy

## After Getting SSL

### 1. Update Your Database Protocol

Once SSL is active, update your database:

```sql
-- Update to HTTPS
SELECT update_protocol_setting('https://');

-- Verify the change
SELECT get_current_protocol();
```

### 2. Test Your Website

Check these URLs work:
- `https://yourdomain.com`
- `https://yourdomain.com/shop`
- `https://yourdomain.com/game/1`

### 3. Force HTTPS (Optional)

Add to your `.htaccess` file (Apache):
```apache
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
```

Or for Nginx:
```nginx
server {
    listen 80;
    server_name yourdomain.com;
    return 301 https://$server_name$request_uri;
}
```

### 4. Update Environment Variables

```bash
# In your .env file
VITE_PROTOCOL=https://
```

## Testing SSL Setup

### 1. Browser Test
- Visit `https://yourdomain.com`
- Look for the padlock icon
- Check for any mixed content warnings

### 2. SSL Checker Tools
- [SSL Labs](https://www.ssllabs.com/ssltest/)
- [Why No Padlock](https://www.whynopadlock.com/)
- [SSL Checker](https://www.sslshopper.com/ssl-checker.html)

### 3. Mixed Content Check
- Open browser developer tools
- Look for any HTTP resources being loaded
- Fix any mixed content issues

## Troubleshooting

### Common Issues

**Mixed Content Warnings**
- Check for hardcoded `http://` URLs in your code
- Update image URLs to use relative paths or HTTPS
- Check third-party scripts and resources

**Certificate Not Trusted**
- Wait 24-48 hours for full propagation
- Clear browser cache
- Check certificate installation

**Redirect Loops**
- Check your redirect rules
- Ensure both HTTP and HTTPS are configured properly

**Images Not Loading**
- Update your database protocol setting
- Check image URLs in your code
- Verify Supabase Storage URLs

## Security Best Practices

### 1. HTTP Strict Transport Security (HSTS)
Add to your server configuration:
```apache
Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
```

### 2. Content Security Policy (CSP)
```html
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
```

### 3. Secure Cookies
Ensure your authentication cookies use:
- `Secure` flag
- `HttpOnly` flag
- `SameSite` attribute

## Cost Comparison

| Option | Cost | Setup Difficulty | Features |
|--------|------|------------------|----------|
| Let's Encrypt | Free | Easy | Basic SSL |
| Cloudflare | Free | Very Easy | SSL + CDN + Security |
| Hosting SSL | $0-50/year | Easy | Basic SSL |
| Paid SSL | $50-500/year | Medium | Extended validation |

## Recommendation

**For most users**: Start with **Let's Encrypt** or **Cloudflare**
- Both are free
- Easy to set up
- Provide good security
- Can upgrade later if needed

## Next Steps

1. **Choose your SSL option** based on your hosting
2. **Follow the setup steps** for your chosen method
3. **Test your SSL** using the tools above
4. **Update your database** protocol setting
5. **Monitor for issues** and fix any mixed content

Once SSL is working, your murder mystery game website will be secure and ready for production! 