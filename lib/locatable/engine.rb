require 'sidekiq'
require 'sidekiq-scheduler'

module Locatable
  class Engine < ::Rails::Engine
    isolate_namespace Locatable
    config.generators.api_only = true

    config.after_initialize do |app|
      Sidekiq.configure_server do |cfg|
        cfg.on :startup do
          Locatable::Engine.load_sidekiq_scheduler(cfg)
        end

      end

    end

    class << self

      def load_sidekiq_scheduler(cfg)
        sidekiq_scheduler_version = SidekiqScheduler::VERSION.to_i
        schedule_file = Locatable::Engine.root.join('config', 'locatable_schedule.yml')
        locatable_schedule = YAML.load_file(schedule_file).dig(:versions, sidekiq_scheduler_version)
        case sidekiq_scheduler_version
        when 4
          if locatable_schedule
            schedule = schedule.merge(locatable_schedule)
            cfg.schedule= schedule
            queues = cfg[:queues] || []
          queues = queues + [Locatable.config.sidekiq.options[:queue]]
            SidekiqScheduler::Scheduler.instance.reload_schedule!
          end
        when 5
          if locatable_schedule
            schedule = (Sidekiq.schedule || {}).dup
            schedule = schedule.merge(locatable_schedule)
            Sidekiq.schedule= schedule
            Sidekiq.default_configuration.queues= cfg[:queues] + [Locatable.config.sidekiq.options[:queue]]
            SidekiqScheduler::Scheduler.instance.reload_schedule!
          end
        end
      end

    end

  end
end
