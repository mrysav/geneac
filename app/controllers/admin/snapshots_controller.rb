module Admin
  class SnapshotsController < Admin::ApplicationController
    def new
      CreateSnapshotJob.perform_later
      flash[:notice] = I18n.t 'administrate.snapshot.create'
      redirect_to :admin_snapshots
    end
  end
end
