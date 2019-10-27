# 20191012-MohsinKhawas-NYCSchools

# SchoolApp (Gave the app a name called SchoolApp)
> SchoolApp is an iOS App for NYC School Data, where the app fetches a list of Schools and their SAT Scores.

## Features

- Schools List View:
   On launch, NYC School Logo is shown.
   Later fetch schools progress is shown which fetches the school details and on success data is shown the Tableview.
   Data like, School name, City and Navigate is shown.
   On error, proper error is thrown for the user.

  - Navigate:
  Clicking on Navigate button, opens up the Maps and shows the Navigtion options.

- Detail View:
  Shows the school SAT Scores and map Area.
  Shows the school address, contact information and more.

- Codable Protocol:
  Have used the Codable protocol for JSON Serialization. To mainly showcase the use of Swift. 

- Unit Tests:
  Have written Unit tests for my Network Manager class to fetch API's.

- Screenshots:
    The folder screenshots has few screenhots while fetch, fetch more and display error.

## Requirements

- Xcode 10.3+ and Xcode 11
- Languages used:
    Swift and Objective C.
- No third party frameworks used. To showcase own skills and use of own network class rather frameworks.
