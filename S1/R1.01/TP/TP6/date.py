def VerifierDate(jour : float, mois : float, annee : float) -> bool :
    """
    Vérifie si une date est valide

    :param jour: un entier
    :param mois: un entier
    :param annee: un entier

    :return: un booléen
    """

    est_bissextile : bool
    mois_ok : bool
    jour_ok : bool
    fevrier_ok : bool
    date_ok : bool

    est_bissextile = (annee % 4 == 0 and annee % 100 != 0) or (annee % 400 == 0)
    mois_ok = ((mois) >= 1 and (mois <= 12))
    fevrier_ok = ((est_bissextile) and (jour <= 29)) or ((not est_bissextile) and (jour <= 28))
    jour_ok = ((jour >= 1) and (fevrier_ok or ((mois != 2 and mois != 4 and mois != 6 and mois != 9 and mois != 11) and (jour <= 31)) or ((mois == 4 or mois == 6 or mois == 9 or mois == 11) and (jour <= 30))))
    date_ok = (jour_ok and mois_ok and (annee > 1582))

    return date_ok
