# Emacstodon

Emacstodon is an Elisp extension for the [Emacs](https://www.gnu.org/software/emacs/) text editor that enables a user to posty (or "toot") the contents of a given buffer to a [Mastodon](https://joinmastodon.org) instance.

## Installation Instructions

1. Download and save the file [emacstodon.el](https://raw.githubusercontent.com/igb/emacstodon/master/emacstodon.el) to a local directory on the computer where you run Emacs.

2. Locate your *.emacs* file in your home directory and add the following line:
```Elisp
(load "/path/of/local/directory/where/file/was/saved/into/emacstodon")
```
Note that you do not need the ".el" filename extension in the path, just the path of the local directory in which the downloaded file resides followed by the string "emacstodon".

If you do not have a *.emacs* in your home directory go ahead and create an empty file and add the line described above.

```Shell
touch ~/.emacs; echo  '(load "/path/of/local/directory/where/file/was/saved/into/emacstodon")' >> ~/.emacs
```

3. Configure Mastodon instance info & credentials:

The Emacstodon extension is going to need credentials in order to post Toots as you on your Mastodon instance. To get these credentials, you will need to register an app and then generate credentials that Emacstodon will use to authN and authZ with your Mastodon instance when sending Toots.
  
  * To get started, go to your Mastodon preferences and click on the *Development* link.  Then click on the *New Application* button.

  * Give your app a name and make sure it has *write* permissions.
  
  * After you have created and saved your app, copy the access token value.
  
  * On your local machine, create a *.emacstodon* file in your home directory (*~/*) and enter the information generated above in the following format/order:


```Text
MASTODON_HOST=mastodon.hccp.org
ACCESS_TOKEN=vrGZ3026iVNIZKj5ip9onv7VvLVG6yC3zG3ErwFHYiCjqmVISq
```

Your values will differ, obviously, but make sure the property names are the same.

Ok, now you are good to go. Just launch or restart Emacs!

## How to Tweet

**TL;DR:** *M-x tweet*

### Details ###
1. Open a new buffer or file.
2. Type or enter the Tweet content into the buffer.
3. *M-x tweet* will then, if the buffer length is 140 characters or less, send your Tweet.
4. Look for the message *"Tweeted!"* to confirm your Tweet was successfully sent.
5. If an error occurred the error message will be displayed in the Message minibuffer.

## Questions? ##

You can always contact me with any questions at [@igb](https://twitter.com/igb).
