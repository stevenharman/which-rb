# frozen_string_literal: true

RSpec.describe Which do
  it "delegates to Executable.find" do
    allow(Which::Executable).to receive(:find)

    Which.call("sweet")

    expect(Which::Executable).to have_received(:find).with("sweet")
  end
end
