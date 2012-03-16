class AddDescriptionToSharingModes < ActiveRecord::Migration
  def change
    add_column :sharing_modes, :description, :text

    sm1 = SharingMode.find_by_name 'Confirm_Once'
    sm1.description = 'Confirm once means that the first time you share records with someone, ' +
      'you need to call or email that person to give them a confirmation code. ' + 
      'This ensures they are who you think they are, and that you don\'t have the wrong email address. ' +
      'After this first time you can share any record with this person without needing to exchange any codes ever again.'
    sm1.save

    sm2 = SharingMode.find_by_name 'Confirm_Always'
    sm2.description = 'Confirm always means each contact will always need to input a unique confirmation code before getting records. ' +
      'This the most secure option.'
    sm2.save

    sm = SharingMode.find_by_name('Confirm_Never')
    sm.description = 'Confirm never means no confirmation code is ever needed to download records. ' +
      'This is the least secure option.'
    sm.save!
  end
end
