# -*- coding: utf-8 -*-

BOT_NAME = 'Berlin Sights'

SPIDER_MODULES = ['berlin.spiders']
NEWSPIDER_MODULE = 'berlin.spiders'

USER_AGENT = 'berlin (+http://www.yourdomain.com)'

# Obey robots.txt rules
ROBOTSTXT_OBEY = True

ITEM_PIPELINES = {'berlin.pipelines.BerlinMySQLPipeline': 800}
