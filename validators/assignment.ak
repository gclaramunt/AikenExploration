use aiken/hash.{Blake2b_224, Hash}
use aiken/list
use aiken/transaction.{OutputReference, ScriptContext, Spend, Transaction}
use aiken/transaction/credential.{VerificationKey}

type Datum {
  owner: Hash<Blake2b_224, VerificationKey>,
}

validator {
  fn pay_to_owner(datum: Datum, _redeemer: Data, context: ScriptContext) -> Bool {
    list.has(context.transaction.extra_signatories, datum.owner)
  }
}

test pays_to_owner() {
  let owner_hash = hash.blake2b_256("owner")
  let datum: Datum = Datum(owner_hash)
  let ref =
    OutputReference {
      transaction_id: transaction.placeholder().id,
      output_index: 0,
    }
  let tx =
    Transaction { ..transaction.placeholder(), extra_signatories: [owner_hash] }
  let context = ScriptContext { transaction: tx, purpose: Spend(ref) }
  pay_to_owner(datum, "", context)
}

test doesnt_pay_if_not_owner() {
  let owner_hash = hash.blake2b_256("owner")
  let datum: Datum = Datum(owner_hash)
  let ref =
    OutputReference {
      transaction_id: transaction.placeholder().id,
      output_index: 0,
    }
  let tx =
    Transaction {
      ..transaction.placeholder(),
      extra_signatories: [hash.blake2b_256("not_owner")],
    }
  let context = ScriptContext { transaction: tx, purpose: Spend(ref) }
  !pay_to_owner(datum, "", context)
}
