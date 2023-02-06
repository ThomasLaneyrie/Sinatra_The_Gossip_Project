class Gossip
  attr_accessor :author, :content, :array_comments
  
  def initialize(author, content)
    @content = content
    @author = author
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@content, @author]
    end
  end
  
  def self.add_comments(id, comments)
    new_csv = CSV.read("db/gossip.csv")
    new_csv[id].push(comments.to_s)
    file = File.open("db/gossip.csv", "w")
      new_csv.each do |row|
        text_row = ""
        row.each do |elements|
          if text_row == ""
            text_row = elements
          elsif text_row != ""
            text_row = "#{text_row},#{elements}"
          end
        end
        File.write("db/gossip.csv","#{text_row}\n", mode: "a")
      end
  end

  def self.update(id, new_author, new_content)
    new_csv = CSV.read("db/gossip.csv")
    @array_comments = find_comments(id)
    new_csv.delete_at(id)
    new_csv.insert(id, [new_content, new_author, @array_comments.join(",")])
    file = File.open("db/gossip.csv", "w")
      new_csv.each do |row|
        if row[2] == nil
          File.write("db/gossip.csv","#{row[0]},#{row[1]}\n", mode: "a")
        else 
          File.write("db/gossip.csv","#{row[0]},#{row[1]},#{row[2]}\n", mode: "a")
        end
      end
  end

  def self.find(id)
    csv = CSV.read("./db/gossip.csv").at(id)      # Ressort un array avec 2 infos : content et auteur
    Gossip.new(csv[1],csv[0])                     # Retransforme pour renvoyer l'info sous une classe Gossip
  end

  def self.find_comments(id)
    @array_comments = Array.new
    csv = CSV.read("./db/gossip.csv").at(id) 
    csv.each_with_index do |elements, index|
        if index == 0 
        elsif index == 1
        else 
          @array_comments.push(elements)
        end
      end
    return @array_comments
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

