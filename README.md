The speedtest tool requires you send requests from a domain registered with it.  I've set up one for beanspeedtest.com.  So, add `127.0.0.1 beanspeedtest.com` to your hosts file and access your local dev site through `beanspeedtest.com` instead of `localhost:3000`.  You'll have to either run the server on port 80 or forward that url to port 3k on localhost.

