# -*- coding: utf-8 -*-

BOT_NAME = 'sainsburys'

SPIDER_MODULES = ['sainsburys.spiders']
NEWSPIDER_MODULE = 'sainsburys.spiders'

USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' \
             ' (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36'

ROBOTSTXT_OBEY = True

LOG_LEVEL = 'INFO'

FEED_EXPORT_ENCODING = 'utf-8'

CONCURRENT_REQUESTS = 1

DOWNLOADER_MIDDLEWARES = {
    'scrapy_splash.SplashCookiesMiddleware': 720,
    'scrapy_splash.SplashMiddleware': 725,
    'scrapy.downloadermiddlewares.httpproxy.HttpProxyMiddleware': 750,
    'scrapy.downloadermiddlewares.httpcompression.HttpCompressionMiddleware': 810,
}

SPIDER_MIDDLEWARES = {
    'scrapy_splash.SplashDeduplicateArgsMiddleware': 100,
}

SPLASH_URL = 'http://localhost:8050/'
DUPEFILTER_CLASS = 'scrapy_splash.SplashAwareDupeFilter'
HTTPCACHE_STORAGE = 'scrapy_splash.SplashAwareFSCacheStorage'
