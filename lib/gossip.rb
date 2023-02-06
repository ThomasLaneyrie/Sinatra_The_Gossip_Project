class Gossip
  attr_accessor :author, :content
  
  def initialize(author, content)
    @content = content
    @author = author
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@content, @author]
    end
  end

  def self.update(id, new_author, new_content)
    new_csv = CSV.read("db/gossip.csv")
    new_csv.delete_at(id)
    new_csv.insert(id, [new_author, new_content])
    file = File.open("db/gossip.csv", "w")
      new_csv.each do |row|
      File.write("db/gossip.csv","#{row[0]},#{row[1]}\n", mode: "a")
      end
  end

  def self.find(id)
    csv = CSV.read("./db/gossip.csv").at(id)      # Ressort un array avec 2 infos : content et auteur
    Gossip.new(csv[1],csv[0])                     # Retransforme pour renvoyer l'info sous une classe Gossip
  end

  def self.all
    all_gossips = Array.new
    csv = CSV.read("db/gossip.csv", :headers=>true)
    csv.each do |row|
      all_gossips << Gossip.new(row['author'], row['content'])
    end
    return all_gossips
  end
end

