import http.cookiejar
import browser_cookie3

# Load the browser's cookies
cj = browser_cookie3.load(domain_name='.pixiv.net')

# Create a MozillaCookieJar object to save the cookies in Netscape format
ncj = http.cookiejar.MozillaCookieJar('cookies.txt')

# Transfer cookies from CookieJar (browser_cookie3) to MozillaCookieJar
for cookie in cj:
    ncj.set_cookie(cookie)

# Save the MozillaCookieJar cookies to a file
ncj.save(ignore_discard=True, ignore_expires=True)
