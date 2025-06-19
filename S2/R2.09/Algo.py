from typing import Callable

def dichotomie(f: Callable[[float], float], a: float, b: float, tol: float = 1e-7) -> float:
    """
    Algorithme de dichotomie pour trouver une racine de la fonction f dans l'intervalle [a, b].
    
    :param f: Fonction pour laquelle on cherche une racine.
    :param a: Borne inférieure de l'intervalle.
    :param b: Borne supérieure de l'intervalle.
    :param tol: Tolérance pour l'arrêt de l'algorithme.
    :return: Approximation de la racine de f.
    """
    if f(a) * f(b) > 0:
        raise ValueError("La fonction doit changer de signe sur l'intervalle [a, b].")
    
    while (b - a) / 2.0 > tol:
        c = (a + b) / 2.0
        if f(c) == 0:
            return c
        elif f(a) * f(c) < 0:
            b = c
        else:
            a = c
    
    return (a + b) / 2.0

if __name__ == "__main__":
    def f(x: float) -> float:
        return x**2 - 2

    racine = dichotomie(f, 0, 2)
    print(f"La racine approximative est : {racine}")