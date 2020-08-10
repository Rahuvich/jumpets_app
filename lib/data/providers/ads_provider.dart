import 'dart:async';
import 'dart:convert';

import 'package:jumpets_app/models/enums/categories.dart';
import 'package:jumpets_app/data/api_base_helper.dart';

class AdsProvider {
  final ApiBaseHelper _api;

  AdsProvider()
      : this._api = ApiBaseHelper(baseUrl: 'http://192.168.1.45:3030/graphql');

  Future<dynamic> getPaginatedAds(
      {Category category,
      int first,
      String after,
      int photosWidth,
      int photosHeight,
      int thumbnailWidth,
      int thumbnailHeight}) async {
    return _api.post({
      'query': ''' query {
    ads(category: $category, first: $first, after: $after) {
      totalCount
      edges{
        node{
          id: _id
          tags
          photos(options: {width: $photosWidth, height: $photosHeight})
          ... on ProductAd {
            title
            description
            price
            type: __typename
          }
          ... on ServiceAd {
            title
            description
            priceHour
            type: __typename
          }
          ... on AnimalAd {
            name
            description
            activityLevel
            birthDate
            male
            adoptionTax
            weight
            personality
            mustKnow
            deliveryInfo
            breed
            type
            ... on Dog {
              size
            }
          }
          createdAt
          creator {
            id: _id
            type: __typename
            thumbnail(options: {
              width: $thumbnailWidth,
              height: $thumbnailHeight
            })
            name
            address
            phone
            ... on Protectora {
              web
            }
            ... on Profesional {
              web
            }
          }
        }
        cursor
      }
      pageInfo: {
        hasNextPage
        endCursor
      }
    }
  }'''
    });
  }
}