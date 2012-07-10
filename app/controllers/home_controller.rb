class HomeController < UIViewController
  def viewDidLoad
    @tableView = UITableView.alloc.init
    @tableView.dataSource = self
    @tableView.frame = [[0, 0], [view.frame.size.width, view.frame.size.height]]

    BW::HTTP.get("http://api.ihackernews.com/page") do |response|
      json = BW::JSON.parse(response.body.to_str)
      @posts = json["items"]
      view.addSubview(@tableView)
    end
  end

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @posts.length
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    simpleTableIdentifier = "SimpleTableItem"

    tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) ||
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: simpleTableIdentifier).tap do |cell|
      cell.textLabel.text = @posts[indexPath.row]["title"]
      cell.textLabel.numberOfLines = 2
      cell.textLabel.font = UIFont.fontWithName("Helvetica", size:13)
    end
  end

  def tableView(tableView, titleForHeaderInSection:section)
    "Hacker News"
  end
end
