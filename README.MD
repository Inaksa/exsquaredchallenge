To whomever reads this.

The project was made using XCode 16.0 (16A242d) and targets iOS 18 and uses SwiftUI.

I used the JSON provided in the pdf document as the datasource for the list of cats (this implies that no API was used)

The tag list was taken from a previous project I made, that in turn was part of an article explaining how to implement said component (an article I read about a couple of years ago)

In a real world scenario, the detail would likely be added but as I ran out of time I decided to leave it out. You can add cats but not edit them.

Assumptions:

* The JSON implies that all cats have owners, since the value for owner is a string or it says "null" (as also a string), I assumed what was meant was that those "null" mean there are no owner.

* Since the guidelines were very lax when it came to the UI I created rather simple screens, with not much going on regarding design, I sticked to the basics.

Things to I saw:

* The model on the JSON is very different than caas. And the cats' ids dont have a matching picture in the caas API sometimes. This can be seen in the list not showing the picture of the first two cats for example.

* Those cats with no corresponding picture display a "Missing" text. For those that have, I used the Async image. 

* I also made a little cache to store the images as I retrieve them and dumped them in files, so during runs the same images are not requested twice (this could be improved to store them between runs).

* Implemented a list of cats that contain all tags for a each cat, this list allows tapping on a tag and that single tag will be displayed with the whole text. The list also implements an infinite scrolling (the limit is reached when no results are returned), it allows to search (it works like filtering) and it supports pull to refresh. This implies that in order to get to the detail page you need to click the outside of the list of tags.

* When the user performs a search, it is done against all cats in the list locally, meaning that only already listed cats will be filtered.

* The search criteria is compared against the tags for a given cat and the owner field. The way it is implemented goes twice over the list of tags, this means you perform the comparision at O(2n + 1) in the worst case (O(n)),  where n is the number of tags and the "+ 1" is related to adding the owner to the list of valid compares.

* The detail screen, shows all tags (unlike the cells of the list all tags are expanded), the updatedAt and createdAt are displayed at the bottom using a relative formatting.

* In the detail screen, you can see a bigger version of the cat's picture, and tapping it will present the photo at its maximun size. This pictures are not requested over the network since the cache already haves them.

Potential improvements:

* Since the list of cats was provided, it is used locally, within the project there is a file Datasource.json which has it, however a real world app would probably request the list from the server.

* There's a rudimentary paging system to get a page with n results. In this version the value of n is fixed and it is defined in the Configuration class. This could change to better suit the user preferences.

* Back to the JSON file, this presents an issue, since you can't parse "up to the nth element", everything ends in memory, this works for a small list but a bigger one with hundreds would probably run into memory issues. A solution would be to retrieve the elements with an from a server where the API supports pagination.

* Since there is no local storage cats added are not stored between runs. Also refreshing the list will cause anything added to be lost. The reason is that new cats are stored in memory and the refresh cleans everything.

* The screen to add a cat could use much more love, right now it allows to provide a name for the cat (something that the JSON provided does not include), enter the owner and modifying the tags list. I could have made this a bottom sheet in the cat list view. Another improvement could be defining the picture for a given cat. Finally, the user may leave the Add New Cat without saving, an alert should be used asking if the user wants to save the changes.
