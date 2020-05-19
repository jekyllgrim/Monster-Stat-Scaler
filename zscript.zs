version "4.3.0"

class MonsterHPScaler : EventHandler {
	override void WorldThingSpawned (Worldevent e) {
		if (e.thing && e.thing.bISMONSTER) {			
			e.thing.A_SetHealth(e.thing.health * Clamp(sv_monsterhealthmul,0,10000));
		}
		if (e.thing && e.thing.player)
			e.thing.GiveInventory("MonsterDamageScaler",1);
	}
}

Class MonsterDamageScaler : Inventory {
	Default {
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		inventory.maxamount 1;
	}
	override void Tick() {}
	override void ModifyDamage (int damage, Name damageType, out int newdamage, bool passive, Actor inflictor, Actor source, int flags) {
		if (!source || !owner || !passive)
			return;
		if (source.bISMONSTER && !source.bFRIENDLY)
			newdamage = Clamp(damage * sv_monsterdamagemul,0,10000);
		//Console.Printf("%s, expected: %d, dealt: %d",source.GetClassName(),damage,newdamage);
	}
}