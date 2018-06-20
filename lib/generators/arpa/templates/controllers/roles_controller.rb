module Arpa
  class RolesController < ApplicationController
    before_action :set_role, only: %i[show edit update remove]

    # GET /roles
    def index
      @roles = role_finder.all
    end

    # GET /roles/1
    def show; end

    # GET /roles/new
    def new
      @role = Arpa::Entities::Role.new
      all_resources
    end

    # GET /roles/1/edit
    def edit
      all_resources
    end

    # POST /roles
    def create
      role_creator.create({ role: role_params },
                          success: redirect_to_index(I18n.t('flash.actions.create_role.notice')),
                          fail: render_errors(:new))
    end

    # PATCH/PUT /roles/1
    def update
      role_updater.update({ role: role_params },
                          success: redirect_to_index(I18n.t('flash.actions.update_role.notice')),
                          fail: render_errors(:edit))
    end

    # DELETE /roles/1
    def remove
      role_remover.remove({ role: @role },
                          success: redirect_to_index(I18n.t('flash.actions.remove_role.notice')),
                          fail: redirect_to_index(I18n.t('flash.actions.remove_role.alert')))
    end

    private

    def redirect_to_index(message)
      lambda do |_role|
        redirect_to roles_path, notice: message
      end
    end

    def render_errors(action_to_render)
      lambda do |error|
        @role = Arpa::Entities::Role.new(role_params)
        @error = error
        all_resources
        render action_to_render
      end
    end

    def role_creator
      @role_creator ||= Arpa::Services::Roles::RoleManagerCreator.new
    end

    def role_updater
      @role_updater ||= Arpa::Services::Roles::RoleManagerUpdater.new
    end

    def role_remover
      @role_remover ||= Arpa::Services::Roles::RoleManagerRemover.new
    end

    def role_finder
      @role_finder ||= Arpa::Repositories::Roles::Finder.new
    end

    def resource_finder
      @resource_finder ||= Arpa::Repositories::Resources::Finder.new
    end

    def all_resources
      @resources = resource_finder.all
    end

    def set_role
      @role = role_finder.find(params[:id])
    end

    def role_params
      permitted_params = %i[id name description]

      params.require(:role)
            .permit(permitted_params, action_ids: [])
            .to_h
    end
  end
end
