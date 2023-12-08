#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
    Responsible module to create controllers.
"""

from ..base import BaseHandlerFeatureTable, BaseHandlerFeatureTableColumn
from modules.common import auth_non_browser_based


# FEATURE TABLE

class APIFeatureTable(BaseHandlerFeatureTable):

    # A list of URLs that can be use for the HTTP methods
    urls = [r"/api/feature_table/?(?P<param>[A-Za-z0-9-]+)?/",
            r"/api/feature_table/?(?P<param>[A-Za-z0-9-]+)?"]

    def get(self, param=None):
        self.get_method_api_resource()

    @auth_non_browser_based
    def post(self, param=None):
        self.post_method_api_resource(param)

    # @auth_non_browser_based
    # def put(self, param=None):
    #     self.put_method_api_resource(param)

    # @auth_non_browser_based
    # def delete(self, param=None):
    #     self.delete_method_api_resource(param)


class APIFeatureTableColumn(BaseHandlerFeatureTableColumn):

    # A list of URLs that can be use for the HTTP methods
    urls = [r"/api/feature_table_column/?(?P<param>[A-Za-z0-9-]+)?/",
            r"/api/feature_table_column/?(?P<param>[A-Za-z0-9-]+)?"]

    # def get(self, param=None):
    #     self.get_method_api_resource()

    @auth_non_browser_based
    def post(self, param=None):
        self.post_method_api_resource(param)

    # @auth_non_browser_based
    # def put(self, param=None):
    #     self.put_method_api_resource(param)

    @auth_non_browser_based
    def delete(self, param=None):
        self.delete_method_api_resource(param)
