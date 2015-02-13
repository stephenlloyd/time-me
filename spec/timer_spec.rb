require 'timer'
require 'timecop'

describe Timer do
  context "starting" do
    before{allow(File).to receive(:open)}

    it "creates a file" do
      expect(File).to receive(:open).with ".timer", "w"
      Timer.starter
    end

    it "informs that the timer has started" do
      allow(File).to receive(:open).with ".timer", "w"
      expect(Timer.starter).to eq 'Timer started. Go!!!'
    end

  end

  context "stopping" do
    before{allow(File).to receive(:open)}

    it "reads the time if it can" do
      expect(File).to receive(:mtime).with ".timer"
      Timer.stoper
    end

    it "reads the times" do
        freeze_time
        expect(Timer).to receive(:humanize).with 65
        Timer.stoper
    end

    it "saves the file when stopeed" do
        freeze_time
        expect(File).to receive(:open).with ".timer", "a"
        Timer.stoper
    end

    it "returns the correct message when finished timing" do
        freeze_time
        expect(Timer.stoper).to eq "It took 1 minutes 5 seconds."
    end

    it "errors gracefully if there isnt's file" do
      expect(Timer.stoper).to eq "You haven't started yet. Type 'starter' to begin and 'stoper' to end"
    end

    it "tells me how many seconds it took" do
      expect(Timer.humanize(63)).to eq "1 minutes 3 seconds"
    end


    def freeze_time
        Timecop.freeze(Time.local(2015, 2, 13, 12, 0, 0))
        allow(File).to receive(:mtime).with(".timer").and_return Time.now
        Timecop.freeze(Time.local(2015, 2, 13, 12, 1, 05))
    end

  end
end

