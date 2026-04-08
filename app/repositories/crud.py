from app.db import get_db

def crea(dato1:str):
    db = get_db()
    db.execute(
        """INSERT INTO tabella (dato1) VALUES (?)""",(dato1,)
    )
    db.commit()

def cancella(id:int):
    db = get_db()
    db.execute(
        """DELETE FROM tabella WHERE id = ?""",(id,)
    )
    db.commit()

def ottieni_dati():
    db = get_db()
    query = """SELECT * FROM tabella"""
    dati = db.execute(query).fetchall()
    return [dict(dato) for dato in dati]

def user_by_id(id):
    db = get_db()
    query = """SELECT * FROM users WHERE id = ?"""
    dati = db.execute(query, (id,)).fetchone()
    return dati

def aggiorna(id,nuovo_valore):
    db = get_db()
    query = """
        UPDATE tabella
        SET dato1 = ?
        WHERE id = ?
        """
    
    db.execute(query, (nuovo_valore, id))
    db.commit()
