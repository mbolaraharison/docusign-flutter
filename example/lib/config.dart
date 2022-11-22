import 'dart:developer';
import 'dart:io';

import 'package:docusign_flutter/docusign_flutter.dart';
import 'package:docusign_flutter/model/access_token_model.dart';
import 'package:docusign_flutter/model/account_info.dart';
import 'package:docusign_flutter/model/auth_model.dart';
import 'package:docusign_flutter/model/envelope_model.dart';
import 'package:docusign_flutter/model/input_token_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

String accessToken = r'<<NEED_CHANGE>>';
// const String accountId = r'056e5faa-6144-474d-a9ca-252154beb8be';
const String accountId = r'da753101-1517-46e3-97fc-f9e8a1aa695f';
const String email = r'raharison.m@bentouch-digital.com';
// const String email = r'signature@technitoit.com';
const int expiresIn = 28800;
const String host = r'https://demo.docusign.net/restapi';
const String integratorKey = r'515f5a3c-7a4b-49ce-bd89-91fd15a27d76';
// const String integratorKey = r'20401886-f322-4cc1-951a-18ad4bdfab24';
const String userId = r'9c57714a-ef33-4b84-a653-36b920ab5c7e';
// const String userId = r'70846eda-f780-440c-a5d3-ca33479f0e15';
const String userName = r'Mbola Raharison';
// const String userName = r'Signa Ture';
const String publicRSAKey = r'''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoujLc1qE9wjg85yL5dzs
N4L0+iy5dkbUv/R9LXq9qjGJmPsVQJgm0pt644jl0mo9BLTrSXkUBcdc/eXNlw42
BCZFwinmbR7nPqZeT083+H7H5S2vsh7SbYcLsBLv38667tT1zN9evdcUEJKcmhhd
vit7dGEfQ3L0STs6hoSSRNo5QUE59rscf64GUK3aGdHBTP3CWvqBBYD79znlJC6t
5J7k7fmcwwHyhkJ66tIZrNvLxFuUM9M/uSsXv+cIlsQHCijboL7QH4qUb/Qs6ztY
f3NSve2+dW9xVZU3c9vbJaZSgaEMNGpMiq/cu3NjGGbpML6dBWCaHrpg/LyAFAvi
JwIDAQAB
-----END PUBLIC KEY-----
''';
const privateRSAKey = r'''-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAoujLc1qE9wjg85yL5dzsN4L0+iy5dkbUv/R9LXq9qjGJmPsV
QJgm0pt644jl0mo9BLTrSXkUBcdc/eXNlw42BCZFwinmbR7nPqZeT083+H7H5S2v
sh7SbYcLsBLv38667tT1zN9evdcUEJKcmhhdvit7dGEfQ3L0STs6hoSSRNo5QUE5
9rscf64GUK3aGdHBTP3CWvqBBYD79znlJC6t5J7k7fmcwwHyhkJ66tIZrNvLxFuU
M9M/uSsXv+cIlsQHCijboL7QH4qUb/Qs6ztYf3NSve2+dW9xVZU3c9vbJaZSgaEM
NGpMiq/cu3NjGGbpML6dBWCaHrpg/LyAFAviJwIDAQABAoIBAARf4PALiwzWfF0+
TmlmlHdBznyV992hCvR5Rw/nabFoxsueA7+Uy7IVwmfav2Ug54Y5VM9yb2MKVp5r
bdOzv30+s9qCD9x38Hi3tJ+c6SFZ8i80Ggbb71rz6JCaqZNRH1GWKWA40qKhZGS0
3dIA0SpFS6Q1OXGGZDXqimid+w7bNsb8TNXmGdBTuNATk3UnhdC4skI5sRFXfF/r
q5xHSiTyTY2I4T7Xt8m0JQWuRnupqReUhZAdpR+dv5s+XOgeMxtQiB2xnL2+4xCj
2PEfGYOhZ2ZRHIQ2z8LjEzU0wFsAnUd4Cql5IVNQu/gIniTbyZhfHiwgwcOUIy3/
UmwgGvECgYEA+GOfazA2MooUI+4LxR7xmB8hSlluqhbQXy1Ywu5OWsqWaxb58xzC
meGwmH43f4AwYsdp29/y3BIgDLcBOu8zRiy4zjnA49eQg6e3YNgmgUzmEx7jTivf
azUW6Ghd8d1NMj+ehaXCUgpVkLqraMHBguIVa86L/H6LYLu1LIljHzcCgYEAp+aq
ARQcjtV+88xOy991LF5AgWA6pl2Hadb9QMQoqGikZNGstHqKH0qPHKlE+GYC/lMk
UnrU72jZjS57QAs+h/XnnPiSjXTcAWICn0ZaWtAU5LIYc7syyEYlH3XJYEmKX+Nc
PHzLNg3osXoKaCVwdLWxuFGIxQwcdvX3e2IkbJECgYATzo3l1EBeI1ibzN2vaFpH
kSPsc9k5Qvx2unz7fllNMB5yh7CCzGZQMwkL//SY/DXfiptMZz1Mgz1/BhDZDD4A
eIx8FWrmQEhL11HuLQ5U/TbTi4EAuMrmF6OuALSNFuKTATO44JDwTdao5dnJTroJ
n9GpeRz8k3K10gIOfR4kXQKBgCXRtTVs/EnIGUJ9ILqXaONHj6wUquFSa/ARNxZh
mO7mMzFqcUZt27LUrou8LQbuo3n57FKPzGro6Sf98lEotzsUzsjyzMAENJIzK3gI
9s1B1ZL18sAOyI+IDVCazXNc3UhgBCSzz2ork+B2JuXymPQRASkNZItOARNisA4g
uyehAoGBAM689lbmaUyTWU55IeSvLKM84g8XDDXVcq/IXGijOK7Hs1f/dZcvLvSf
R6JxIKmVLC8PrU0zIv5HjFSbrk/BKMK0f1v18/AU3jvNhRN7SluVyY/KhdqxAUc5
wXLbFErgcrjmIO6jZj69ERGvDNv8T4kukqvNesAo2uZjG/ujBsOd
-----END RSA PRIVATE KEY-----
''';
// const String privateRSAKey = r'''-----BEGIN RSA PRIVATE KEY-----
// MIIEpAIBAAKCAQEAg7oxY6fO5kGXgpE2mJ+C3SShElsq+HpqcFNktLRJYFtm7ygc
// owbCATaFbP4v39vO+6HHZGcNu3qszwi3bpZXH1+5g/UiRjakpuuF6lT7oeRdwhiJ
// F/MlX6koNtVDHxQGVxQsy2X3kHfUu/hG5n5/JTkEQzmjLSIty35WXS/aTz+GG8aO
// BQHI/oX8Wxc8nGhht6/JBXdYP/8l+uWp0p4uS3izcoUX4W0trnhLWNm7EOP9eN1A
// IC1GjFUDzypaEUXFKBS2s9JfRpfkUvUOERkQoNz7uM5/ciwkIg/T5uOP3i/pPhMa
// wpV2EPy2eEGaFShe4KDqBoUhryiImZ2BLnfhtQIDAQABAoIBAA6uHbpKcES5mJtP
// eEh9YQXTgt6F1H3JPrrH6xg3DgUJX/5VImPfaULeAvPzm/2UWeEx1VkmIaH8I5gV
// vkOPyPkmdN6figijJv8HORm1YNmuQUNT8qtS80j8PrllqPZPXVQvsRJLNHzK2KVz
// dOCpG52tWKvul3XR3Pf/BhGajKIk0Hcvwgbr/lH/XxYC5v77D6P+D2PDxq3/MrV4
// 9WaA32vhnGr9+3EI8C8iOpZi9GlVTUnMhKMAcFOTpGXPrdGBEPp00MmfhHIBDPdv
// OLUqkBT1RYcOjDVanApsmub/jbJFQihTgzloGrxtV3dujveZkJOSFHyKsG5BVVh9
// WIKAF70CgYEA6A0KemIue5ki4izJoT0F+6UtPJ5COyGGNicZmEFbeIu/HDfVfxA3
// DcNTqTVHCw+Y9iEn78Alar4LXPI6Q+v9KLm6W57px7jk9oSg7WrVch7wLlDVXacx
// q1s5een7KT/dM69oCJUkzcaXS9dG37/NKRid7zEUQ0g+jk4qXkyVb98CgYEAkVKG
// 5aMa5x4srU+jD4wJhd+Oc822vV4y/0vbq7R9JHW+OvdB4ld6YmtSR4XEPq/nPYoY
// SEuR7Js4O396URtDXCEhooj5h+cMtPuwh0PO8w4ssd41d/mLRsr/VoInwpwd0Gi+
// OXvrTp+dI7SYaGb63FafVAE5mC9yyJxGtxI70OsCgYEA41LzMtVACCEKxVtu4x/u
// 3oj/+eRnqZm76wz+y+MrArqUK8aexe1SoY76REdHI5TSGjx87Sfk/97RLuq1HZjv
// 1per8tmI1/lPhBiFtk/0benVDOpvO2HxDJc/hSksvUotHtb1KYNCHLwxt0Bb1BIH
// n/zXq1z/JrJ9Zdc5Nkv8ES0CgYEAjZjdCgn4H7Q+EgzjtDVd3gyrL9kEstWDWVAf
// 1dmCijETzz62+oUEIbuyqzACvJYG+eaBrIe9ws6nZwnaNAcdhjpeHJHcmXge4IXR
// RqtijV+FWzZJ4QHMnIkVbMRbW3tkbXpxx28gIzbRFUZVrnyQ+HqKun6LEOdCr4fe
// O2lP0UsCgYBncNrxoloE9HaAPBccC/SIgQBosZKCQcZnUsQcvOwjtEeauKKbzqWL
// 8CcqCH7xRQQm25nJHziUTOs0gh5R7HpKol6+uRaKRKl2H8gdvXar/WpmBR9z1Ith
// R6DmNhZknrR+jw2tcFqan59lcg3H2Ap+cIG1ycz9y7aDoBzA2uj6rA==
// -----END RSA PRIVATE KEY-----''';
// const String publicRSAKey = r'''-----BEGIN PUBLIC KEY-----
// MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAg7oxY6fO5kGXgpE2mJ+C
// 3SShElsq+HpqcFNktLRJYFtm7ygcowbCATaFbP4v39vO+6HHZGcNu3qszwi3bpZX
// H1+5g/UiRjakpuuF6lT7oeRdwhiJF/MlX6koNtVDHxQGVxQsy2X3kHfUu/hG5n5/
// JTkEQzmjLSIty35WXS/aTz+GG8aOBQHI/oX8Wxc8nGhht6/JBXdYP/8l+uWp0p4u
// S3izcoUX4W0trnhLWNm7EOP9eN1AIC1GjFUDzypaEUXFKBS2s9JfRpfkUvUOERkQ
// oNz7uM5/ciwkIg/T5uOP3i/pPhMawpV2EPy2eEGaFShe4KDqBoUhryiImZ2BLnfh
// tQIDAQAB
// -----END PUBLIC KEY-----''';

const String envelopeId = r'<<NEED_CHANGE>>';
const String recipientClientUserId = r'<<NEED_CHANGE>>';
const String recipientEmail = r'<<NEED_CHANGE>>';
const String recipientUserName = r'<<NEED_CHANGE>>';

class Config extends StatefulWidget {
  const Config({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  AccountInfoModel? _accountInfoModel;
  String? _docusignObserver;
  String? _offlineEnvelopeId;
  bool? _syncingStatus;
  bool? _offlineSigningStatus;
  AccessTokenModel? _accessTokenModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Center(
              child: Column(children: [
                Text('Token status: ${_accessTokenModel?.access_token}\n'),
                ElevatedButton(
                  onPressed: () => _getAccessToken(),
                  child: const Text('AccessToken'),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text('Auth status:${_accountInfoModel?.email}\n')),
                ElevatedButton(
                  onPressed: () => _auth(),
                  child: const Text('Auth'),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text('Envelope Id (OFFLINE):$_offlineEnvelopeId\n')),
                ElevatedButton(
                  onPressed: () => _createOfflineEnvelope(),
                  child: const Text('Create offline enveloppe'),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                        'Offline signing status: ${_convertStatus(_offlineSigningStatus)}\n')),
                ElevatedButton(
                  onPressed: () => _offlineSigning(),
                  child: const Text('Offline signing'),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text('OBSERVER:$_docusignObserver\n')),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                        'Syncing status: ${_convertStatus(_syncingStatus)}\n')),
                ElevatedButton(
                  onPressed: () => _syncingEnvelopes(),
                  child: const Text('Syncing'),
                ),
              ]),
            ),
          );
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    DocusignFlutter.listenObserver(_onEvent, _onError);
  }

  Future<void> _getAccessToken() async {
    var inputToken = InputTokenModel(
        url: 'account-d.docusign.com',
        urlPath: '/oauth/token',
        integratorKey: integratorKey,
        userId: userId,
        publicRSAKey: publicRSAKey,
        privateRSAKey: privateRSAKey);
    var result = await DocusignFlutter.getAccessToken(inputToken);
    setState(() {
      _accessTokenModel = result;
      if (result?.access_token != null) {
        accessToken = result!.access_token;
      }
    });
  }

  Future<void> _auth() async {
    var authModel = AuthModel(
      accessToken: accessToken,
      expiresIn: expiresIn,
      accountId: accountId,
      email: email,
      host: host,
      integratorKey: integratorKey,
      userId: userId,
      userName: userName,
    );
    var result = await DocusignFlutter.auth(authModel);
    setState(() {
      _accountInfoModel = result;
    });
  }

  Future<void> _createOfflineEnvelope() async {
    FilePickerResult? filePickerResult = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (filePickerResult != null &&
        filePickerResult.files.single.path != null) {
      File file = File(filePickerResult.files.single.path!);
      var envelopeModel = EnvelopeModel(
          filePath: filePickerResult.files.single.path!,
          envelopeName: 'test',
          envelopeSubject: 'test',
          envelopeMessage: 'message',
          hostName: 'Mbola Raharison',
          hostEmail: 'raharison.m@bentouch-digital.com',
          inPersonSignerName: 'Mbolatina Arimanana Raharison',
          inPersonSignerEmail: 'mb.raharison@gmail.com',
          signerName: 'Mbolatina Arimanana Raharison',
          signerEmail: 'mb.raharison@gmail.com');
      var result = await DocusignFlutter.createEnvelope(envelopeModel);
      setState(() {
        _offlineEnvelopeId = result;
      });
    } else {
      // User canceled the picker
    }
  }

  void _onEvent(Object? event) {
    setState(() {
      _docusignObserver = event.toString();
    });
  }

  void _onError(Object error) {
    setState(() {
      _docusignObserver = error.toString();
    });
  }

  Future<void> _offlineSigning() async {
    var result = false;
    try {
      await DocusignFlutter.offlineSigning(_offlineEnvelopeId ?? '');
      result = true;
    } on Exception {
      result = false;
    }

    setState(() {
      _offlineSigningStatus = result;
    });
  }

  Future<void> _syncingEnvelopes() async {
    var result = false;
    try {
      await DocusignFlutter.syncEnvelopes();
      log('sync true ');
      result = true;
    } on Exception {
      log('sync false ');
      result = false;
    }
    setState(() {
      _syncingStatus = result;
    });
  }

  String _convertStatus(bool? status) {
    if (status != null) {
      return status ? 'success' : 'failed';
    }
    return 'none';
  }
}
