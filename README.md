# Integrity Test

## Description

The Integrity Test is script created to generate, compare and verify file integrity using sha256sum or md5sum test.

## Execution

1. To run the script, first of all, clone the project or download the zipped source code to your local machine.
2. Access the project folder and open terminal and run the command to add execution permission:
```
$ sudo chmod +x integrity-test.sh
```
3. run the command to run script.
```
$ ./integrity-test.sh
```

For ease of use you can create a symbolic link to a directory of binaries and be able to call it from the terminal. To do this, just run the following commands.

```
$ sudo mv integrity-test.sh /usr/sbin/
$ sudo ln -s /usr/sbin/integrity-test.sh /usr/bin/integrity-test
```

You can integrate it into the context menu to make it easier to run.
Create a file in the directory `/usr/share/nemo/actions/` with name `integrity-test.nemo_action` containing the following instructions:

```
[Nemo Action]
Name=Integrity Test
Comment=Hash sha256sum and md5sum test
Exec=integrity-test '%F'
Extensions=any;
Icon-Name=edit-find-symbolic
Active=true
Selection=None
```

## Contributors

[Luciano Brito](https://github.com/lucianobritodev)

Brazilian, married, born in 1991, passionate about technology. Graduated in Systems Analysis and Development from Paulist University (UNIP) in 2019. 


## Contacts

- [LinkeIn](https://www.linkedin.com/in/luciano-brito-dev)
- [Gmail](mailto:lucianobrito.dev@gmail.com)
- [Instagram](https://www.instagram.com/lucianobrito.dev)


## Donates

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/donate/?hosted_button_id=SX3L4N89M8ZRW)