# frozen_string_literal: true

RSpec.shared_examples 'records the edit history' do
  it 'adds a edit history entry for the change' do
    expect(
      EditHistory.last.attributes.values_at('action', 'editable_type', 'editable_id', 'edited_at', 'user_id')
    ).to eq([action, resource.class.to_s, resource.id, edited_at, user.id])
  end
end
