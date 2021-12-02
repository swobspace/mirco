# frozen_string_literal: true

class PagesController < ApplicationController
  skip_load_and_authorize_resource
  load_and_authorize_resource class: false

  def index
    @pages = Dir["#{File.join(Rails.root, 'app', 'views', 'pages')}/*.adoc"]
    @pages = @pages.map { |p| p.split(%r{/})[-1].gsub(/.adoc/, '') }
  end

  def show
    if valid_page?
      doc = File.read(document_path)
      render html: Asciidoctor.convert(doc).html_safe, layout: 'application'
    else
      render file: 'public/404.html', status: :not_found
    end
  end

  private

  def document_path
    Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.adoc")
  end

  def valid_page?
    File.exist?(document_path)
  end

  def add_breadcrumb_solo
    # add_breadcrumb("kb#{params[:id]}", kbarticles_path(params[:id]))
  end
end
