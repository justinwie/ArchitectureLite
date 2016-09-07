# ArchitectureLite
---
ArchitectureLite provides Object Relational Mapping, converting data between incompatible types (SQL to Ruby).

## ArchitectureLite Methods
---
- `::all` : fetches an array of all records from the Database for that model
-  `::find` : finds the model with the corresponding `id`
- `::where` : searches the Database for given params and returns the resulting objects
-  `#insert` : inserts a new row with the given params
-  `#update` : updates a row with the given params
-  `#save` : inserts or updates a row depending on if the `id` exists
- `belongs_to`, `has_many` : creates a new method to access the `belongs_to` or `has_many` association
- `has_one_through` : combines `belongs_to` associations to make a join query using the options of `table_name`, `foreign_key`, and `primary_key`. These values are stored in `assoc_options`. This method then fetches the associated object
    + takes in three arguments: `association name`, `the third model name`, and `source model name`

## 3-Step Demo

1. Clone this repo
```bash
git clone https://github.com/justinwie/ArchitectureLite.git
```
2. Load `irb` or `pry` and enter `load 'demo.rb'`
```bash
[1] pry(main)> load 'demo.rb'
=> true
```
3. Access the available methods!
  - Character.all
  ```bash
  [2] pry(main)> Character.all
  => [#<Character:0x007f801ab66358
  @attributes={:id=>1, :name=>"Sherlock Holmes", :show_id=>1}>,
   #<Character:0x007f801ab66178
   @attributes={:id=>2, :name=>"John Watson", :show_id=>1}>,
   #<Character:0x007f801ab65f98
   @attributes={:id=>3, :name=>"Carrie Mathison", :show_id=>2}>,
   #<Character:0x007f801ab65d18
   @attributes={:id=>4, :name=>"Saul Berenson", :show_id=>2}>,
   #<Character:0x007f801ab659d0
   @attributes={:id=>5, :name=>"Daenerys Targaryen", :show_id=>3}>,
   #<Character:0x007f801ab65520
   @attributes={:id=>6, :name=>"Tyrion Lannister", :show_id=>3}>,
   #<Character:0x007f801ab65098
   @attributes={:id=>8, :name=>"Robin Scherbatsky", :show_id=>4}>]
 ```
 - Character.find(5)
 ```bash
 [3] pry(main)> Character.find(5)
  => #<Character:0x007f801a3d3780
  @attributes={:id=>5, :name=>"Daenerys Targaryen", :show_id=>3}>
```
  - Character.where({show_id: 2})
```bash
[4] pry(main)> Character.where({show_id: 2})
=> [#<Character:0x007fd3e10d6490
@attributes={:id=>3, :name=>"Carrie Mathison", :show_id=>2}>,
 #<Character:0x007fd3e10d6350
 @attributes={:id=>4, :name=>"Saul Berenson", :show_id=>2}>]
```
  - Associations
  ```bash
  [5] pry(main)> John = Character.find(2)
  => #<Character:0x007fd3e11ec9b0
  @attributes={:id=>2, :name=>"John Watson", :show_id=>1}>

    [6] pry(main)> John.show
    => #<Show:0x007fd3e119ccd0
    @attributes={:id=>1, :name=>"Sherlock", :showType_id=>2}>

    [7] pry(main)> John.show.characters
    => [#<Character:0x007fd3e11751f8
    @attributes={:id=>1, :name=>"Sherlock Holmes", :show_id=>1}>,
     #<Character:0x007fd3e11750b8
     @attributes={:id=>2, :name=>"John Watson", :show_id=>1}>]
 ```
