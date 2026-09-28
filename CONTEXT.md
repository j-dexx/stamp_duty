# StampDuty

Calculates Stamp Duty Land Tax owed on a residential property purchase in England and Northern Ireland.

## Language

**Stamp Duty**:
Stamp Duty Land Tax (SDLT) owed on a purchase, rounded down to the whole pound.
_Avoid_: LBTT, LTT (Scottish and Welsh equivalents, out of scope)

**Purchase Price**:
The amount paid for the property, on which Stamp Duty is charged. Never negative.
_Avoid_: value, consideration

**Band**:
A slice of the Purchase Price between a lower and optional upper bound, taxed at a single percentage rate.
_Avoid_: bracket, tier

**Taxable Amount**:
The part of the Purchase Price that falls within one Band.

**Band Amount**:
The tax due on a Band's Taxable Amount.

**Calculation**:
The result for one purchase: its Purchase Price, Band Amounts and Stamp Duty.

**First-Time Buyer Relief**:
Reduced Bands for buyers who have never owned a home, available only when the Purchase Price is £500,000 or less.

**Surcharge**:
Percentage points added to every Band's rate. Two exist: the **Additional Property** surcharge (buyer will own more than one home) and the **Non-Resident** surcharge (buyer not UK resident). Neither applies below £40,000.
_Avoid_: higher rates (ambiguous with the higher Bands)

## Relationships

- A **Purchase Price** falls into one or more **Bands**, starting from the lowest
- **First-Time Buyer Relief** replaces the standard **Bands**; **Surcharges** add to whichever **Bands** apply
- A **First-Time Buyer** cannot also be buying an **Additional Property**
- Each **Band** the price reaches produces one **Band Amount**
- **Stamp Duty** is the sum of the **Band Amounts**, rounded down to the pound

## Flagged ambiguities

- "Stamp duty" colloquially covers Scottish LBTT and Welsh LTT; here it means SDLT for England and Northern Ireland only.
- Rates are those in force from 1 April 2025; purchases completed earlier used different rates.
