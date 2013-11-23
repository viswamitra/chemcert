class AddLocationRelations
  def self.enroll
      #"postalcode","town","state"
      file_csv = CSV.parse(File.open('location_relations.csv'))
      file_csv.each do |row|
        begin
          postal_code = row[0]
          town = row[1]
          state = row[2]

          p = PostalCode.create(:code => postal_code.to_s)
          t = Town.create(:name => town.to_s)
          s = State.create(:name => state.to_s)
          #
          p ||= PostalCode.find_by_code(postal_code.to_s)
          t ||= Town.find_by_name(town.to_s)
          s ||= State.find_by_name(state.to_s)
          #
          LocationRelation.create(:postal_code_id => p.id, :town_id => t.id, :state_id => s.id)


        rescue Exception => e
            p "error -> #{e}"
        end
      end
    end
end
AddLocationRelations.enroll
