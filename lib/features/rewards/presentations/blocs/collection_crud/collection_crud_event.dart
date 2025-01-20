part of 'collection_crud_bloc.dart';

sealed class CollectionCrudEvent extends Equatable {
  const CollectionCrudEvent();

  @override
  List<Object> get props => [];
}

final class LoadCollectionData extends CollectionCrudEvent {}
