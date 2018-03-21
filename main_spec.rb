# Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overpopulation.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

require_relative './world'
require_relative './life'

describe World do
  let(:world) { described_class.new(seed) }

  # it 'can tick' do
  #   expect { world.tick }.to change { world.lives }.from(['Bob']).to(['Jane'])
  # end

  context 'when the life is underpopulated' do 
    let(:seed) { [[0,0]] }
    it 'dies' do
      expect(world.at(0, 0)).not_to be_nil
      world.tick
      expect(world.at(0, 0)).to be_nil
    end
  end

  context 'when the life has two neighbors' do
    let(:seed) {[[0,0], [0, 1], [0, -1]]}
    it 'lives on' do
      expect(world.at(0, 0)).not_to be_nil
      world.tick
      expect(world.at(0,0)).not_to be_nil
    end
  end

  context 'when the life is overpopulated' do
    let(:seed) {[[0,0], [0, -1], [1, 1], [0, 1], [-1, -1]]}
    it 'dies' do
      expect(world.at(0,0)).not_to be_nil
      world.tick
      expect(world.at(0,0)).to be_nil
    end
  end
end

describe Life do
  let(:life) { described_class.new(0,0) }

  it 'has a name' do
    expect(life.name).to be_a String
  end
end
