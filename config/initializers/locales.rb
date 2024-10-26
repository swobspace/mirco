# frozen_string_literal: true

Rails.application.config.i18n.available_locales = %i[de en]
Rails.application.config.i18n.default_locale = (ENV['LOCALE'] || 'de').to_sym

