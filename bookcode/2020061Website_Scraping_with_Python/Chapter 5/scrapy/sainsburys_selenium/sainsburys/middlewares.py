# -*- coding: utf-8 -*-

from scrapy import signals
from scrapy.http import HtmlResponse
from scrapy.utils.python import to_bytes
from selenium import webdriver
from selenium.webdriver.firefox.options import Options


class SeleniumDownloaderMiddleware:

    def __init__(self):
        self.driver = None

    @classmethod
    def from_crawler(cls, crawler):
        middleware = cls()
        crawler.signals.connect(middleware.spider_opened, signals.spider_opened)
        crawler.signals.connect(middleware.spider_closed, signals.spider_closed)
        return middleware

    def process_request(self, request, spider):
        self.driver.get(request.url)
        body = to_bytes(self.driver.page_source)
        return HtmlResponse(self.driver.current_url, body=body, encoding='utf-8', request=request)

    def spider_opened(self, spider):
        options = Options()
        options.set_headless()
        self.driver = webdriver.Firefox(options=options)

    def spider_closed(self, spider):
        if self.driver:
            self.driver.close()
            self.driver.quit()
            self.driver = None
