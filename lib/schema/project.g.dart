// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProjectCollection on Isar {
  IsarCollection<Project> get projects => this.collection();
}

const ProjectSchema = CollectionSchema(
  name: r'Project',
  id: 3302999628838485849,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'isPinned': PropertySchema(
      id: 1,
      name: r'isPinned',
      type: IsarType.bool,
    ),
    r'isUploaded': PropertySchema(
      id: 2,
      name: r'isUploaded',
      type: IsarType.bool,
    ),
    r'label': PropertySchema(
      id: 3,
      name: r'label',
      type: IsarType.string,
    ),
    r'memo': PropertySchema(
      id: 4,
      name: r'memo',
      type: IsarType.string,
    ),
    r'orders': PropertySchema(
      id: 5,
      name: r'orders',
      type: IsarType.objectList,
      target: r'Order',
    ),
    r'payments': PropertySchema(
      id: 6,
      name: r'payments',
      type: IsarType.objectList,
      target: r'Payment',
    ),
    r'vehicle': PropertySchema(
      id: 7,
      name: r'vehicle',
      type: IsarType.string,
    )
  },
  estimateSize: _projectEstimateSize,
  serialize: _projectSerialize,
  deserialize: _projectDeserialize,
  deserializeProp: _projectDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'Order': OrderSchema, r'Payment': PaymentSchema},
  getId: _projectGetId,
  getLinks: _projectGetLinks,
  attach: _projectAttach,
  version: '3.1.0+1',
);

int _projectEstimateSize(
  Project object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.label.length * 3;
  bytesCount += 3 + object.memo.length * 3;
  bytesCount += 3 + object.orders.length * 3;
  {
    final offsets = allOffsets[Order]!;
    for (var i = 0; i < object.orders.length; i++) {
      final value = object.orders[i];
      bytesCount += OrderSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.payments.length * 3;
  {
    final offsets = allOffsets[Payment]!;
    for (var i = 0; i < object.payments.length; i++) {
      final value = object.payments[i];
      bytesCount += PaymentSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.vehicle.length * 3;
  return bytesCount;
}

void _projectSerialize(
  Project object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.date);
  writer.writeBool(offsets[1], object.isPinned);
  writer.writeBool(offsets[2], object.isUploaded);
  writer.writeString(offsets[3], object.label);
  writer.writeString(offsets[4], object.memo);
  writer.writeObjectList<Order>(
    offsets[5],
    allOffsets,
    OrderSchema.serialize,
    object.orders,
  );
  writer.writeObjectList<Payment>(
    offsets[6],
    allOffsets,
    PaymentSchema.serialize,
    object.payments,
  );
  writer.writeString(offsets[7], object.vehicle);
}

Project _projectDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Project();
  object.date = reader.readDateTime(offsets[0]);
  object.id = id;
  object.isPinned = reader.readBool(offsets[1]);
  object.isUploaded = reader.readBool(offsets[2]);
  object.label = reader.readString(offsets[3]);
  object.memo = reader.readString(offsets[4]);
  object.orders = reader.readObjectList<Order>(
        offsets[5],
        OrderSchema.deserialize,
        allOffsets,
        Order(),
      ) ??
      [];
  object.payments = reader.readObjectList<Payment>(
        offsets[6],
        PaymentSchema.deserialize,
        allOffsets,
        Payment(),
      ) ??
      [];
  object.vehicle = reader.readString(offsets[7]);
  return object;
}

P _projectDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readObjectList<Order>(
            offset,
            OrderSchema.deserialize,
            allOffsets,
            Order(),
          ) ??
          []) as P;
    case 6:
      return (reader.readObjectList<Payment>(
            offset,
            PaymentSchema.deserialize,
            allOffsets,
            Payment(),
          ) ??
          []) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _projectGetId(Project object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _projectGetLinks(Project object) {
  return [];
}

void _projectAttach(IsarCollection<dynamic> col, Id id, Project object) {
  object.id = id;
}

extension ProjectQueryWhereSort on QueryBuilder<Project, Project, QWhere> {
  QueryBuilder<Project, Project, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ProjectQueryWhere on QueryBuilder<Project, Project, QWhereClause> {
  QueryBuilder<Project, Project, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Project, Project, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Project, Project, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Project, Project, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProjectQueryFilter
    on QueryBuilder<Project, Project, QFilterCondition> {
  QueryBuilder<Project, Project, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> isPinnedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPinned',
        value: value,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> isUploadedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUploaded',
        value: value,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> memoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> memoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> memoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> memoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> memoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> memoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> memoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> memoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> memoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> memoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memo',
        value: '',
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> ordersLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> ordersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> ordersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> ordersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> ordersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> ordersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'orders',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> paymentsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payments',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> paymentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payments',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> paymentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payments',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> paymentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payments',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition>
      paymentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payments',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> paymentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'payments',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> vehicleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> vehicleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> vehicleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> vehicleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> vehicleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> vehicleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> vehicleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> vehicleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> vehicleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicle',
        value: '',
      ));
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> vehicleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicle',
        value: '',
      ));
    });
  }
}

extension ProjectQueryObject
    on QueryBuilder<Project, Project, QFilterCondition> {
  QueryBuilder<Project, Project, QAfterFilterCondition> ordersElement(
      FilterQuery<Order> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'orders');
    });
  }

  QueryBuilder<Project, Project, QAfterFilterCondition> paymentsElement(
      FilterQuery<Payment> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'payments');
    });
  }
}

extension ProjectQueryLinks
    on QueryBuilder<Project, Project, QFilterCondition> {}

extension ProjectQuerySortBy on QueryBuilder<Project, Project, QSortBy> {
  QueryBuilder<Project, Project, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByIsPinnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.desc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByIsUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUploaded', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByIsUploadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUploaded', Sort.desc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByVehicle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicle', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> sortByVehicleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicle', Sort.desc);
    });
  }
}

extension ProjectQuerySortThenBy
    on QueryBuilder<Project, Project, QSortThenBy> {
  QueryBuilder<Project, Project, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByIsPinnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPinned', Sort.desc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByIsUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUploaded', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByIsUploadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUploaded', Sort.desc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByMemo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByMemoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memo', Sort.desc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByVehicle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicle', Sort.asc);
    });
  }

  QueryBuilder<Project, Project, QAfterSortBy> thenByVehicleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicle', Sort.desc);
    });
  }
}

extension ProjectQueryWhereDistinct
    on QueryBuilder<Project, Project, QDistinct> {
  QueryBuilder<Project, Project, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<Project, Project, QDistinct> distinctByIsPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPinned');
    });
  }

  QueryBuilder<Project, Project, QDistinct> distinctByIsUploaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUploaded');
    });
  }

  QueryBuilder<Project, Project, QDistinct> distinctByLabel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'label', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Project, Project, QDistinct> distinctByMemo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Project, Project, QDistinct> distinctByVehicle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicle', caseSensitive: caseSensitive);
    });
  }
}

extension ProjectQueryProperty
    on QueryBuilder<Project, Project, QQueryProperty> {
  QueryBuilder<Project, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Project, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<Project, bool, QQueryOperations> isPinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPinned');
    });
  }

  QueryBuilder<Project, bool, QQueryOperations> isUploadedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUploaded');
    });
  }

  QueryBuilder<Project, String, QQueryOperations> labelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'label');
    });
  }

  QueryBuilder<Project, String, QQueryOperations> memoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memo');
    });
  }

  QueryBuilder<Project, List<Order>, QQueryOperations> ordersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orders');
    });
  }

  QueryBuilder<Project, List<Payment>, QQueryOperations> paymentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'payments');
    });
  }

  QueryBuilder<Project, String, QQueryOperations> vehicleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicle');
    });
  }
}
