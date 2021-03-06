# -*- coding: utf-8 -*-
############################################################
#
# Autogenerated by the KBase type compiler -
# any changes made here will be overwritten
#
############################################################

from __future__ import print_function
# the following is a hack to get the baseclient to import whether we're in a
# package or not. This makes pep8 unhappy hence the annotations.
try:
    # baseclient and this client are in a package
    from .baseclient import BaseClient as _BaseClient  # @UnusedImport
except:
    # no they aren't
    from baseclient import BaseClient as _BaseClient  # @Reimport


class genome_browser(object):

    def __init__(
            self, url=None, timeout=30 * 60, user_id=None,
            password=None, token=None, ignore_authrc=False,
            trust_all_ssl_certificates=False,
            auth_svc='https://kbase.us/services/authorization/Sessions/Login'):
        if url is None:
            raise ValueError('A url is required')
        self._service_ver = None
        self._client = _BaseClient(
            url, timeout=timeout, user_id=user_id, password=password,
            token=token, ignore_authrc=ignore_authrc,
            trust_all_ssl_certificates=trust_all_ssl_certificates,
            auth_svc=auth_svc)

    def get_gff(self, genome_ref, context=None):
        """
        :param genome_ref: instance of String
        :returns: instance of type "GenomeToGFFResult" -> structure:
           parameter "gff_file" of type "File" -> structure: parameter "path"
           of String, parameter "shock_id" of String, parameter "ftp_url" of
           String, parameter "from_cache" of type "boolean"
        """
        return self._client.call_method(
            'genome_browser.get_gff',
            [genome_ref], self._service_ver, context)

    def get_fasta(self, genome_ref, context=None):
        """
        :param genome_ref: instance of String
        :returns: instance of type "GenomeToGFFResult" -> structure:
           parameter "gff_file" of type "File" -> structure: parameter "path"
           of String, parameter "shock_id" of String, parameter "ftp_url" of
           String, parameter "from_cache" of type "boolean"
        """
        return self._client.call_method(
            'genome_browser.get_fasta',
            [genome_ref], self._service_ver, context)

    def status(self, context=None):
        return self._client.call_method('genome_browser.status',
                                        [], self._service_ver, context)
