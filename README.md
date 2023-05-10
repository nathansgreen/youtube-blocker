# youtube channel blocker

Managed profiles and YouTube Kids profiles can be blocked from individual channels.
But no API or tool exists to manage this feature.

Until now.

This is a cross-platform shell script package that can be used to block channels
(or unblock if you know how to change it) on YouTube in an organized way.
Once you've followed the [setup instructions](#setup-instructions), you can
run the script as follows:
```
kidGaiaId="123456789" channelId=bm94aW91cy1jb250ZW50 ./ytblock.sh
```
While we recommend that you keep copies of `channelId`s and use them directly,
you can also just pass in the channel name and that API call will be made for you:
```
kidGaiaId="123456789" channelSlug=ToxicInfluencer ./ytblock.sh
```


## Motivation

Some people have more than one child profile to manage.
It is also nice to be able to have a complete list of channels that you've blocked.
Adding a new child profile after you've configured existing profile(s) is a thing
that happens, and this tool will help you stay organized.

## Setup Instructions

The quickest way to get started is to use developer tools in a web browser and look
at a request going through.
For example, you can copy the request as a <code>[curl](https://curl.se)</code>
command, save it to a file, and then extract the values you need.
You can create the 3 files you will need by running `setup.sh` or just do it manually.

First, copy the request body into the file <code>[request.json](request.json)</code>.
This will be the template for future requests.

Second, copy the cookies into the file named <code>[cookies](cookies)</code>.

Finally, you'll need to fill out a <code>[credentials](credentials)</code> file with
values set for the following variables:
```
key=
x_client_data=
x_goog_authuser=0
x_goog_visitor_id=
```

### Client Identification

For your convenience, the files <code>[conf.ua.curlrc](conf.ua.curlrc)</code>
and <code>[conf.x.curlrc](conf.x.curlrc)</code> are pre-populated with values,
but you may wish to change them to match your current client.

