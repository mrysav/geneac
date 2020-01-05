module Admin
  class SnapshotsController < Admin::ApplicationController
    def new
      CreateSnapshotJob.perform_later
      flash[:notice] = I18n.t 'administrate.snapshot.create'
      redirect_to :admin_snapshots
    end

    def restore
      RestoreSnapshotJob.perform_later(Snapshot.find(params[:snapshot_id]))
      flash[:notice] = I18n.t 'administrate.snapshot.restore_initiated'
      redirect_to admin_snapshot_path(params[:snapshot_id])
    end
  end
end
