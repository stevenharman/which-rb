# frozen_string_literal: true

require "which/executable"

RSpec.describe Which::Executable do
  subject(:which) { described_class.new(env: fake_env) }
  let(:fake_env) { {"PATH" => path.join(File::PATH_SEPARATOR)} }
  let(:path) { ["/tmp/fake_dir"] }
  let(:project_root_dir) { Pathname(__dir__).join("../..") }
  let(:fixture_path) { project_root_dir.join("spec/fixtures").to_path }

  it "finds the command when it exists on the first entry in $PATH" do
    path.prepend(fixture_path)

    expect(which.find("sweet")).to eq(project_root_dir.join("spec/fixtures/sweet").to_path)
  end

  it "does not find the command when the file does not have execute permissions" do
    path.prepend(fixture_path)

    expect(which.find("sweet_non_exe")).to be_nil
  end

  it "does not find the command when it is a directory" do
    path.prepend(fixture_path)

    expect(which.find("a_directory")).to be_nil
  end

  it "finds the command when it exists on a middle entry in $PATH" do
    path.append(fixture_path)
    path.append("/tmp/some/other/path")

    expect(which.find("sweet")).to eq(project_root_dir.join("spec/fixtures/sweet").to_path)
  end

  it "finds the command when it exists on the last entry in $PATH" do
    path.append("/tmp/some/other/path")
    path.append(fixture_path)

    expect(which.find("sweet")).to eq(project_root_dir.join("spec/fixtures/sweet").to_path)
  end

  it "does not find the command when the file is not in $PATH" do
    expect(which.find("sweet")).to be_nil
  end

  it "finds the command when an absolute path is given" do
    absolute_path = project_root_dir.join("spec/fixtures/sweet").to_path

    expect(which.find(absolute_path)).to eq(absolute_path)
  end

  it "does not find the command when an absolute path to a directory is given" do
    absolute_path = project_root_dir.join("spec/fixtures/a_directory").to_path

    expect(which.find(absolute_path)).to be_nil
  end

  context "on Windows" do
    before do
      path.append(fixture_path)

      fake_env["PATHEXT"] = ".exe;.bat;.cmd"
    end

    it "finds the command with the extensions defined by $PATHEXT" do
      expect(which.find("sweet_win")).to eq(project_root_dir.join("spec/fixtures/sweet_win.bat").to_path)
    end
  end
end
