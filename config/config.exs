# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

config :noizu_advanced_scaffolding,
       default_audit_engine: Noizu.KitchenSink.V3.AuditEngine,
       default_nmid_generator: Noizu.KitchenSink.V3.NmidGenerator,
       domain_object_schema: Noizu.Support.V3.CMS.DomainObject.Schema

config :sendgrid,
       api_key: System.get_env("NOIZU_SENDGRID_KS_KEY"),
       simulate: false,
       email_site_url: "https://github.com/noizu/KitchenSink"



import_config "#{config_env()}.exs"
