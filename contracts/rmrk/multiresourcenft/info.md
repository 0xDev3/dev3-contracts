# Multiresource NFTs

A resource is a type of output for an NFT: usually a media file.

A resource can be an image, a movie, a PDF file, or even a BASE (a special entity - [see here](https://docs.rmrk.app/lego25-equippable/)). A multi-resource NFT is one that can output a different resource based on specific contextual information, e.g. load a PDF if loaded into a PDF reader, vs. loading an image in a virtual gallery.

A resource is NOT an NFT or a standalone entity you can reference. It is part of an NFT - one of several outputs it can have.

Every RMRK NFT has zero or more resources. When it has zero resources, the metadata is "root level". Any new resource added to this NFT will override the root metadata, making this NFT revealable.